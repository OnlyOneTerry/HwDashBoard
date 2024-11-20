#include "CanUtil.h"
#include <QTimer>

using namespace srvcomps;

#define SRVCOMP_CONF_FILE_PATH (DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWmotionctrl.jconf"))
#define CAN_CONF_FILE_PATH (DEFAULT_UNCAL_CONF_PATH + std::string("/CAN_DB.jconf"))
#define SRVCOMP_CLUSTER_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWcluster.jconf")))


inline void PrintValue(const CanValueMsg& value_msg)
{
    std::cout << ">>>>>>>>>>>> Received value:" << std::endl;
    for (const auto& item : value_msg.value()) {
        std::cout << item.first << ": " << item.second << std::endl;
    }
    std::cout << "<<<<<<<<<<<<" << std::endl;
}

inline void initSrvService(std::string srv_comp_conf_file,std::pair<uint32_t,uint32_t>& srv_id,ServiceComponent& srvcomp_obj)
{
    std::cout << "Service ID: " << srv_id.first << " : " << srv_id.second << std::endl;

    CanMsgBindingConfTable srv_msg_bound = GetCanMsgBindingConf(SRVCOMP_CONF_FILE_PATH);
    if (srv_msg_bound.empty()) {
        std::cout<<"srv_msg_bound is empty "<<std::endl;
        exit(1);
    }

    CanMsgParser can_parser(CAN_CONF_FILE_PATH);
    for (auto const &item : srv_msg_bound) {
        for (auto const &sig_name : item.second) {
            can_parser.BindMsg(item.first, sig_name);
        }
    }

    // ServiceComponent srvcomp_powermgmt(srv_id.first);

    srvcomp_obj.InitConsumer(srv_id.second, DataDispatcherType::DDS_CONSUMER, new TypeSupport(new CanValueMsgType()));
    auto func = [](std::shared_ptr<ServiceMsg> data){
        // TODO: send data to can bus

    };
    srvcomp_obj.RegisterAppDataHandler(func);

    srvcomp_obj.RunConsumer(ServiceLifeCycle());
}

CanUtil::CanUtil()
{
    this->start();

    //    QTimer* timer = new QTimer();
    //    timer->setInterval(200);
    //    timer->setSingleShot(false);
    //    connect(timer,&QTimer::timeout,this,[=](){
    //        auto testval = rand()/100.0;
    //        emit  signalSpeed(testval);
    //        emit signalReady(true);
    //        emit signalBatSoc(testval);
    //        emit signalRemainRange(testval);
    //    });
    //    timer->start(100);
}

CanUtil::~CanUtil()
{
    this->quit();
    this->wait();
}


void CanUtil::run()
{
    //motionctrl
    std::pair<uint32_t, uint32_t> srv_id = GetCompSrvIdConf(SRVCOMP_CONF_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_powermgmt(srv_id.first);
    initSrvService(SRVCOMP_CONF_FILE_PATH,srv_id,srvcomp_powermgmt);
    //cluster
    srv_id = GetCompSrvIdConf(SRVCOMP_CLUSTER_CONFIG_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_cluter(srv_id.first);
    initSrvService(SRVCOMP_CLUSTER_CONFIG_FILE_PATH,srv_id,srvcomp_cluter);
    QString time ="00:00";
    //battery

    CanValueMsg* real_msg = nullptr;
    while (true) {
        //motionctrl
        std::shared_ptr<ServiceMsg> srv_msg = nullptr;
        srvcomp_powermgmt.Consume(srv_msg);
        if (srv_msg != nullptr) {
            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
            signalBatSoc(real_msg->value()[GetCanSigIdentity(0x18F101F4, "Bat_SOC")]);
            signalGearMode(real_msg->value()[GetCanSigIdentity(0xC12A1C1, "Three_Gears_Set")]);
            auto rpm = real_msg->value()[GetCanSigIdentity(0x18F001C1, "Realtime_Rot_Speed")];
            signalRpm(rpm);
            //TODO: calculate speed specify r 0.25m
            auto speed = 0.25*rpm;
            signalSpeed(speed);
            signalGear(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Controller_Gear_Pos")]);
            std::cout<<"recieve msg from can ...."<<std::endl;
        }

        //cluster
        srv_msg = nullptr;
        srvcomp_cluter.Consume(srv_msg);
        if (srv_msg != nullptr) {
            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
            signalRemainRange(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Remainder_Mileage")]);
            auto hour = real_msg->value()[GetCanSigIdentity(0x18F003A5, "Hour")];
            auto minute =  real_msg->value()[GetCanSigIdentity(0x18F003A5, "Minute")];
            time = QString("%1:%2").arg(hour).arg(minute);
            signalTime(time);
            emit signalTotalMileage(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Total_Mileage")]);
            signalTripMileage(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Trip_Mileage")]);
            std::cout<<"recieve msg from srvcomp_cluter ...."<<std::endl;
        }


        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }

}
