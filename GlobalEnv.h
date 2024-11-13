#ifndef GLOBALENV_H
#define GLOBALENV_H

#include <QObject>
#include <QSettings>

class GlobalEnv : public QObject
{
    Q_OBJECT
public:
    explicit GlobalEnv(QObject *parent = nullptr);
    Q_INVOKABLE float getTotalMiles()
    {
        QString username = qgetenv("USER");
        //QString tempPath = "/home/"+username+"configure.ini";
        QString tempPath = "/root/tangrui/configure.ini";
        QSettings setting(tempPath,QSettings::IniFormat);
        float totalMiles = setting.value("totalMile").toFloat();
        return totalMiles;
    }

    Q_INVOKABLE void setTotalMiles(float mile){
        QString username = qgetenv("USER");
        //QString tempPath = "/home/"+username+"/configure.ini";
        QString tempPath = "/root/tangrui/configure.ini";
        QSettings setting(tempPath,QSettings::IniFormat);
        setting.setValue("totalMile",mile);
    }
signals:

};

#endif // GLOBALENV_H
