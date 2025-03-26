TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build an ioc application
# Use PROD_IOC_RTEMS for RTEMS only
# Use PROD_IOC_Linux for Linux only
PROD_IOC = vacuum

# vacuum.dbd will be created and installed
DBD += vacuum.dbd

# vacuum.dbd will be made up from these files:
vacuum_DBD += base.dbd
vacuum_DBD += iocAdmin.dbd
vacuum_DBD += asSupport.dbd
vacuum_DBD += asyn.dbd
vacuum_DBD += drvAsynSerialPort.dbd
vacuum_DBD += drvAsynIPPort.dbd
vacuum_DBD += stream.dbd
vacuum_DBD += calc.dbd
vacuum_DBD += history.dbd
# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
vacuum_SRCS += vacuum_registerRecordDeviceDriver.cpp
vacuum_SRCS_DEFAULT += vacuumMain.cpp

# Add locally compiled object code
#vacuum_SRCS += dbSubExample.c

vacuum_LIBS += devIocStats
vacuum_LIBS += autosave
vacuum_LIBS += asyn
vacuum_LIBS += stream
vacuum_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

