#ifndef CANUTIL_H
#define CANUTIL_H
#include <QObject>
#include <QThread>
#include "mhu/uncom_al/uncaif_can.hpp"
#include "service_component/component.hpp"
#include "srv_msg_idl/can_msg_idl/CanMsg.h"
#include "srv_msg_idl/can_msg_idl/CanMsgTypes.h"
#include "srv_msg_idl/can_value_idl/CanValueMsgTypes.h"
#include "utils/can_msg_parser/can_sig_identify.hpp"
#include "utils/can_msg_parser/can_parser.hpp"
#include "utils/srvcomp_conf/srvcomp_conf.hpp"
#include "components/srvcomp_conf.hpp"


class CanUtil: public  QThread
{
    Q_OBJECT
public:
    CanUtil();
    ~CanUtil();

    void DeparseCanMsg(const CanMsg& can_msg,
                             const CanMsgBindingConfTable& can_msg_bound,
                             CanMsgParser& can_parser,
                             CanValueMsg& can_value_msg)
   {
       auto it = can_msg_bound.find(can_msg.id());
       if (it == can_msg_bound.end()) {
           return;
       }
       std::map<uint64_t, double> values;
       for (auto& sig_name : it->second) {
           CanRealValue real_value;
           can_parser.DeserializeSig(can_msg.data().data(), sig_name, real_value);
           values.emplace(GetCanSigIdentity(can_msg.id(), sig_name), real_value);
       }
       can_value_msg.value(values);
   }
signals:
    //display
    void signalSpeed(unsigned char value);
    void signalDriveMode(unsigned char value);
    void signalRpm(int value);
    void signalGear(int value);
    void signalPower(uint value);
    void signalLeftTurnOn(bool value);
    void signalRightTurnOn(bool value);
    void signalGearMode(uint value);//0 1 2 3
    void signalRemainRange(int value);
    void signalReady(bool value);
    void signalBatSoc(short value);
    void signalIsFarLight(bool value);
    void signalPluginIn(bool value);
    void signalAutoHold(bool value);
    void signalDriveEngineWarning(bool value);
    void signalLimitPowerWarning(bool value);
    void signalBatteryOverHotWarning(bool value);
    void signalBatteryWarning(bool value);
    void signalCoolantLowWarning(bool value);
    void signalBrake(bool value);
    void signalClusterTotalMileageReset(bool value);//clear trip
    void signalTime(QString time);
    void signalTotalMileage(float value);
    void signalTripMileage(float value);
    void signalBatteryTemp(float value);
    //warnnig or fault

protected:
    void run();
private:

};

#endif // CANUITL_H
