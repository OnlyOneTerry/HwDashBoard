#include "CanUtil.h"
#include <QTimer>

using namespace srvcomps;

#define SRVCOMP_CONF_FILE_PATH (DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWmotionctrl.jconf"))
#define CAN_CONF_FILE_PATH (DEFAULT_UNCAL_CONF_PATH + std::string("/CAN_DB.jconf"))
#define SRVCOMP_CLUSTER_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWcluster.jconf")));


inline void PrintValue(const CanValueMsg& value_msg)
{
    std::cout << ">>>>>>>>>>>> Received value:" << std::endl;
    for (const auto& item : value_msg.value()) {
        std::cout << item.first << ": " << item.second << std::endl;
    }
    std::cout << "<<<<<<<<<<<<" << std::endl;
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
    std::pair<uint32_t, uint32_t> srv_id = GetCompSrvIdConf(SRVCOMP_CONF_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }

    std::cout << "Service ID: " << srv_id.first << " : " << srv_id.second << std::endl;

    CanMsgBindingConfTable can_msg_bound = GetCanMsgBindingConf(SRVCOMP_CONF_FILE_PATH);
    if (can_msg_bound.empty()) {
        std::cout<<"can_msg_bound is empty "<<std::endl;
        exit(1);
    }

    CanMsgParser can_parser(CAN_CONF_FILE_PATH);
    for (auto const &item : can_msg_bound) {
        for (auto const &sig_name : item.second) {
            can_parser.BindMsg(item.first, sig_name);
        }
    }

    ServiceComponent srvcomp_powermgmt(srv_id.first);

    srvcomp_powermgmt.InitConsumer(srv_id.second, DataDispatcherType::DDS_CONSUMER, new TypeSupport(new CanValueMsgType()));
    auto func = [](std::shared_ptr<ServiceMsg> data){
        // TODO: send data to can bus

    };
    srvcomp_powermgmt.RegisterAppDataHandler(func);

    srvcomp_powermgmt.RunConsumer(ServiceLifeCycle());

   // std::shared_ptr<srvcomps::ServiceMsg> can_value_msg(new srvcomps::ServiceMsg(new TypeSupport(new CanValueMsgType())));

    CanValueMsg* real_msg = nullptr;
    while (true) {
        std::shared_ptr<ServiceMsg> can_msg = nullptr;
        srvcomp_powermgmt.Consume(can_msg);
        if (can_msg != nullptr) {
            real_msg = (CanValueMsg*)can_msg->GetMsgImpl();
            // TODO: emit
            //PrintValue(*real_msg);
            signalBatSoc(real_msg->value()[GetCanSigIdentity(0x18F101F4, "Bat_SOC")]);
            signalGearMode(real_msg->value()[GetCanSigIdentity(0xC12A1C1, "Three_Gears_Set")]);
            auto rpm = real_msg->value()[GetCanSigIdentity(0x18F001C1, "Realtime_Rot_Speed")];
            signalRpm(rpm);
            //TODO: calculate speed specify r 0.25m
            auto speed = 0.25*rpm;
            signalSpeed(speed);
            signalGear(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Controller_Gear_Pos")]);
            signalRemainRange(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Remainder_Mileage")]);
            std::cout<<"recieve msg from can ...."<<std::endl;
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }

}
