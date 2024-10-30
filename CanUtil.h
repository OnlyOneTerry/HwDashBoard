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
    void signalTest(unsigned char num);
protected:
    void run();
private:
   int num_ = 0;
   HandlerCb hb_;
};

#endif // CANUITL_H
