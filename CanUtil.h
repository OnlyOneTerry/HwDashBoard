#ifndef CANUTIL_H
#define CANUTIL_H
#include <QObject>
#include <QThread>

#include "component/battery_cluster_comp/battery_cluster_comp.hpp"
using namespace srvcomps;

class CanUtil: public  QThread
{
    Q_OBJECT
public:
    CanUtil();
    ~CanUtil();
signals:
    void signalTest(int num);
protected:
    void run();
private:
   int num_ = 0;
   HandlerCb hb_;
};

#endif // CANUITL_H
