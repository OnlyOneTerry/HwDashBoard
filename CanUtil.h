#ifndef CANUTIL_H
#define CANUTIL_H
#include <QObject>
#include <QThread>

//#include "component/battery_cluster_comp/battery_cluster_comp.hpp"
#include "component/vcu_cluster_comp/vcu_cluster_comp.hpp"
#include "idl/vcu_idl/VcuMsg.h"

using namespace srvcomps;

class CanUtil: public  QThread
{
    Q_OBJECT
public:
    CanUtil();
    ~CanUtil();
    void showData(VcuMsg* msg);
signals:
    //display
    void signalTest(unsigned char num);
    void signalSpeed(unsigned char value);
    void signalDriveMode(unsigned char value);
    void signalRpm(unsigned char value);
    void signalGear(unsigned char value);
    void signalPower(uint value);
    void signalLeftTurnOn(bool value);
    void signalRightTurnOn(bool value);
    void signalGearMode(uint value);//0 1 2 3
    void signalRemainRange(int value);
    void signalReady(bool value);
    void signalBatSoc(short value);
    //warnnig or fault


protected:
    void run();
private:

   HandlerCb hb_;
};

#endif // CANUITL_H
