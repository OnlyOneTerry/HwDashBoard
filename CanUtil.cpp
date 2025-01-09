#include "CanUtil.h"
#include <QTimer>

using namespace srvcomps;

#define SRVCOMP_MOTIONCTL_CONF_FILE_PATH (DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWmotionctrl.jconf"))
#define CAN_CONF_FILE_PATH (DEFAULT_UNCAL_CONF_PATH + std::string("/CAN_DB.jconf"))
#define SRVCOMP_CLUSTER_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWcluster.jconf")))
#define SRVCOMP_BATTERY_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWbattery.jconf")))
#define SRVCOMP_MODEMGMT_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWmodemgmt.jconf")))
#define SRVCOMP_PWOERMGMT_CONFIG_FILE_PATH ((DEFAULT_SRVCOMP_CONF_PATH + std::string("/HWpowermgmt.jconf")))

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

    CanMsgBindingConfTable srv_msg_bound = GetCanMsgBindingConf(srv_comp_conf_file);
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

      QTimer* timer = new QTimer();
      timer->setInterval(50);
      timer->setSingleShot(false);
      connect(timer,&QTimer::timeout,this,[=](){
          auto testval = rand()%2000;
//          emit  signalSpeed(testval);
//          emit signalReady(true);
//          emit signalBatSoc(testval);
//          emit signalRemainRange(testval);
          emit signalRpm(testval);
      });
      timer->start(1000);
}

CanUtil::~CanUtil()
{
    this->quit();
    this->wait();
}


void CanUtil::run()
{
    //motionctrl
    std::pair<uint32_t, uint32_t> srv_id = GetCompSrvIdConf(SRVCOMP_MOTIONCTL_CONF_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_motionmgmt(srv_id.first);
    initSrvService(SRVCOMP_MOTIONCTL_CONF_FILE_PATH,srv_id,srvcomp_motionmgmt);

    //cluster
    srv_id = GetCompSrvIdConf(SRVCOMP_CLUSTER_CONFIG_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_cluter(srv_id.first);
    initSrvService(SRVCOMP_CLUSTER_CONFIG_FILE_PATH,srv_id,srvcomp_cluter);
    QString time ="00:00";

    //battery
    srv_id = GetCompSrvIdConf(SRVCOMP_BATTERY_CONFIG_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_battery(srv_id.first);
    initSrvService(SRVCOMP_BATTERY_CONFIG_FILE_PATH,srv_id,srvcomp_battery);

    //modemgmt
    srv_id = GetCompSrvIdConf(SRVCOMP_MODEMGMT_CONFIG_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_modemgmt(srv_id.first);
    initSrvService(SRVCOMP_MODEMGMT_CONFIG_FILE_PATH,srv_id,srvcomp_modemgmt);

    //powermgmt
    srv_id = GetCompSrvIdConf(SRVCOMP_PWOERMGMT_CONFIG_FILE_PATH);
    if (srv_id.first == 0 && srv_id.second == 0) {
        exit(1);
    }
    ServiceComponent srvcomp_powermgmt(srv_id.first);
    initSrvService(SRVCOMP_PWOERMGMT_CONFIG_FILE_PATH,srv_id,srvcomp_powermgmt);

    CanValueMsg* real_msg = nullptr;
    std::shared_ptr<ServiceMsg> srv_msg = nullptr;
    while (true) {

        //motionctrl
        srvcomp_motionmgmt.Consume(srv_msg);
        if (srv_msg != nullptr) {
            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
            //signalGearMode(real_msg->value()[GetCanSigIdentity(0xC12A1C1, "Three_Gears_Set")]);
            auto rpm = real_msg->value()[GetCanSigIdentity(0x18F001C1, "Realtime_Rot_Speed")];
            signalRpm(rpm);
            //TODO: calculate speed
            auto speed = 1.953*60*rpm/1000;
            signalSpeed(speed);
            signalGear(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Controller_Gear_Pos")]);
            signalSideStandDrop(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Status_Side_Brace")]);
            signalPGear(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Status_P_Gear")]);
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
            signalTime(QString("%1:%2").arg(hour).arg(minute));
            signalTotalMileage(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Total_Mileage")]);
            signalTripMileage(real_msg->value()[GetCanSigIdentity(0x18F003A5, "Trip_Mileage")]);
        }

        //battery
        srv_msg = nullptr;
        srvcomp_battery.Consume(srv_msg);
        if (srv_msg != nullptr) {
            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
            signalBatSoc(real_msg->value()[GetCanSigIdentity(0x18F101F4, "Bat_SOC")]);
            signalBatteryTemp(real_msg->value()[GetCanSigIdentity(0x18F101F4, "Bat_Temp ")]);
        }

        //modemgmt
//        srv_msg = nullptr;
//        srvcomp_modemgmt.Consume(srv_msg);
//        if (srv_msg != nullptr) {
//            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
//            signalGearMode(real_msg->value()[GetCanSigIdentity(0x0C12A1C1, "Three_Gears_Set ")]);
//        }

        //powermgmt
        srv_msg = nullptr;
        srvcomp_powermgmt.Consume(srv_msg);
        if (srv_msg != nullptr) {
            real_msg = (CanValueMsg*)srv_msg->GetMsgImpl();
            // TODO: emit
            signalKIneEnergyRecovery(real_msg->value()[GetCanSigIdentity(0x18F002C1, "Kinetic_Energy_Recovery ")]);
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }

}
