#ifndef GLOBALENV_H
#define GLOBALENV_H

#include <QObject>
#include <QSettings>

#define CONFIGFILE_PATH "/root/tangrui/configure.ini"

class GlobalEnv : public QObject
{
    Q_OBJECT
public:
    explicit GlobalEnv(QObject *parent = nullptr);
    Q_INVOKABLE float getTotalMiles()
    {
        QString tempPath = CONFIGFILE_PATH;
        QSettings setting(tempPath,QSettings::IniFormat);
        float totalMiles = setting.value("totalMile").toFloat();
        return totalMiles;
    }

    Q_INVOKABLE void setTotalMiles(float mile){
        QString tempPath = CONFIGFILE_PATH;
        QSettings setting(tempPath,QSettings::IniFormat);
        setting.setValue("totalMile",mile);
    }
signals:

};

#endif // GLOBALENV_H
