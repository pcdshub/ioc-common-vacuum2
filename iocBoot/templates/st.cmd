#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-86_64)/vacuum

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "$$TOP")

epicsEnvSet( "MKS937A_CHANNEL_1", "CC")
epicsEnvSet( "MKS937A_CHANNEL_2", "A1")
epicsEnvSet( "MKS937A_CHANNEL_3", "A2")
epicsEnvSet( "MKS937A_CHANNEL_4", "B1")
epicsEnvSet( "MKS937A_CHANNEL_5", "B2")
epicsEnvSet( "MKS937B_cc_setA_ch1", 1)
epicsEnvSet( "MKS937B_cc_setB_ch1", 2)
epicsEnvSet( "MKS937B_cc_setC_ch1", 3)
epicsEnvSet( "MKS937B_cc_setD_ch1", 4)
epicsEnvSet( "MKS937B_cc_setA_ch3", 5)
epicsEnvSet( "MKS937B_cc_setB_ch3", 6)
epicsEnvSet( "MKS937B_cc_setC_ch3", 7)
epicsEnvSet( "MKS937B_cc_setD_ch3", 8)
epicsEnvSet( "MKS937B_cc_setA_ch5", 9)
epicsEnvSet( "MKS937B_cc_setB_ch5", 10)
epicsEnvSet( "MKS937B_cc_setC_ch5", 11)
epicsEnvSet( "MKS937B_cc_setD_ch5", 12)
epicsEnvSet( "MKS937B_pr_setA_ch1", 1)
epicsEnvSet( "MKS937B_pr_setB_ch1", 2)
epicsEnvSet( "MKS937B_pr_setA_ch2", 3)
epicsEnvSet( "MKS937B_pr_setB_ch2", 4)
epicsEnvSet( "MKS937B_pr_setA_ch3", 5)
epicsEnvSet( "MKS937B_pr_setB_ch3", 6)
epicsEnvSet( "MKS937B_pr_setA_ch4", 7)
epicsEnvSet( "MKS937B_pr_setB_ch4", 8)
epicsEnvSet( "MKS937B_pr_setA_ch5", 9)
epicsEnvSet( "MKS937B_pr_setB_ch5", 10)
epicsEnvSet( "MKS937B_pr_setA_ch6", 11)
epicsEnvSet( "MKS937B_pr_setB_ch6", 12)

cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/vacuum.dbd" )
vacuum_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
$$LOOP(DEVICE)
$$IF(HOST)
drvAsynIPPortConfigure( "bus$$INDEX", "$$HOST:$$PORT", 0, 0, 0 )
$$ELSE(HOST)
drvAsynSerialPortConfigure( "bus$$INDEX", "/dev/$$PORT", 0, 0, 0 )
$$ENDIF(HOST)
$$IF(ASYNTRACE)
asynSetTraceMask( "bus$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "bus$$INDEX", 0, 0x0 )
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "bus$$INDEX", 0, 0x1 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("bus$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(DEVICE)

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")

$$LOOP(MKS937A)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(MKS937A)

$$LOOP(MKS937B)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(MKS937B)

$$LOOP(TWISTORR)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(TWISTORR)

$$LOOP(NAVIGATOR)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(NAVIGATOR)

$$LOOP(SRG)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(SRG)

$$LOOP(QPC)
$$IF(HOST)
drvAsynIPPortConfigure( "bus$$INDEX", "$$HOST:$$PORT", 0, 0, 0 )
$$ELSE(HOST)
drvAsynSerialPortConfigure( "bus$$INDEX", "/dev/$$PORT", 0, 0, 0 )
$$ENDIF(HOST)
$$IF(ASYNTRACE)
asynSetTraceMask( "bus$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "bus$$INDEX", 0, 0x2 )
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "bus$$INDEX", 0, 0x1 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("bus$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(QPC)

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(MKS937A)
dbLoadRecords( "db/vac_mks937a_serial.template", "controller=$$BASE,port=$$BASE,slowEvt=3,phase=9" )
$$ENDLOOP(MKS937A)
$$LOOP(MKS937A_SLOT)
dbLoadRecords( "db/vac_mks937a_serial_$$TYPE.template", "device=$$BASE,port=$$MKS937ABASE,channel=$$CHANNEL,slot=$(MKS937A_CHANNEL_$$CHANNEL),fastEvt=1,medEvt=2,slowEvt=3" )
$$ENDLOOP(MKS937A_SLOT)

$$LOOP(MKS937B)
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=$$BASE,port=$$BASE,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
$$ENDLOOP(MKS937B)
$$LOOP(MKS937B_SLOT)
dbLoadRecords( "db/vac_mks937b_serial_$$TYPE.template", "device=$$BASE,port=$$MKS937BBASE,channel=$$CHANNEL,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_$$(TYPE)_setA_ch$$CHANNEL),setpointB=$(MKS937B_$$(TYPE)_setB_ch$$CHANNEL)$$IF(TYPE,cc),setpointC=$(MKS937B_$$(TYPE)_setC_ch$$CHANNEL),setpointD=$(MKS937B_$$(TYPE)_setD_ch$$CHANNEL)$$ENDIF(TYPE)" )
$$ENDLOOP(MKS937B_SLOT)

$$LOOP(TWISTORR)
dbLoadRecords( "db/twistorr_ro.db", "BASE=$$BASE,PORT=$$BASE" )
$$IF(READONLY)$$ELSE(READONLY)
dbLoadRecords( "db/twistorr.db", "BASE=$$BASE,PORT=$$BASE" )
$$ENDIF(READONLY)
$$ENDLOOP(TWISTORR)

$$LOOP(NAVIGATOR)
dbLoadRecords( "db/navigator.db", "BASE=$$BASE,PORT=$$BASE" )
$$ENDLOOP(NAVIGATOR)

$$LOOP(SRG)
dbLoadRecords( "db/srg.db", "BASE=$$BASE,PORT=$$BASE" )
$$IF(TEMP)
dbLoadRecords("db/srg_temp.db", "BASE=$$BASE,TEMP=$$TEMP")
$$ENDIF(TEMP)
$$ENDLOOP(SRG)

$$LOOP(QPC)
dbLoadRecords( "db/qpc_controller_common.db", "BASE=$$BASE, DEV=bus$$INDEX" )
$$IF(FWVERSION,2)
dbLoadRecords( "db/qpc_controller_v2.db", "BASE=$$BASE, DEV=bus$$INDEX" )
$$ENDIF(FWVERSION)

# CH1
$$IF(CH1)
dbLoadRecords( "db/qpc_channel_common.db", "CH_BASE=$$CH1,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=1,TTLCHAN=5" )
$$IF(FWVERSION,1)
dbLoadRecords( "db/qpc_channel_v1.db", "CH_BASE=$$CH1,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=1,TTLCHAN=5" )
$$ENDIF(FWVERSION)
$$IF(FWVERSION,2)
dbLoadRecords( "db/qpc_channel_v2.db", "CH_BASE=$$CH1,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=1,TTLCHAN=5" )
$$ENDIF(FWVERSION)
$$ENDIF(CH1)

# CH2
$$IF(CH2)
dbLoadRecords( "db/qpc_channel_common.db", "CH_BASE=$$CH2,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=2,TTLCHAN=6" )
$$IF(FWVERSION,1)
dbLoadRecords( "db/qpc_channel_v1.db", "CH_BASE=$$CH2,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=2,TTLCHAN=6" )
$$ENDIF(FWVERSION)
$$IF(FWVERSION,2)
dbLoadRecords( "db/qpc_channel_v2.db", "CH_BASE=$$CH2,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=2,TTLCHAN=6" )
$$ENDIF(FWVERSION)
$$ENDIF(CH2)

# CH3
$$IF(CH3)
dbLoadRecords( "db/qpc_channel_common.db", "CH_BASE=$$CH3,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=3,TTLCHAN=7" )
$$IF(FWVERSION,1)
dbLoadRecords( "db/qpc_channel_v1.db", "CH_BASE=$$CH3,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=3,TTLCHAN=7" )
$$ENDIF(FWVERSION)
$$IF(FWVERSION,2)
dbLoadRecords( "db/qpc_channel_v2.db", "CH_BASE=$$CH3,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=3,TTLCHAN=7" )
$$ENDIF(FWVERSION)
$$ENDIF(CH3)

# CH4
$$IF(CH4)
dbLoadRecords( "db/qpc_channel_common.db", "CH_BASE=$$CH4,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=4,TTLCHAN=8" )
$$IF(FWVERSION,1)
dbLoadRecords( "db/qpc_channel_v1.db", "CH_BASE=$$CH4,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=4,TTLCHAN=8" )
$$ENDIF(FWVERSION)
$$IF(FWVERSION,2)
dbLoadRecords( "db/qpc_channel_v2.db", "CH_BASE=$$CH4,DEV=bus$$INDEX,BASE=$$BASE,CHANNEL=4,TTLCHAN=8" )
$$ENDIF(FWVERSION)
$$ENDIF(CH4)

# Asyn Debug
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=bus$$INDEX,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(QPC)


## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

$$LOOP(QPC)
dbpf $$BASE:MODEL.PROC 1
dbpf $$BASE:FWVERSION.PROC 1
dbpf $$BASE:HVSTRAPPING_1.PROC 1
dbpf $$BASE:HVSTRAPPING_2.PROC 1
dbpf $$BASE:ASPOWER.PROC 1

$$IF(CH1)
dbpf $$CH1:PUMPSIZE.PROC 1
dbpf $$CH1:PNAME.PROC 1
dbpf $$CH1:CALFACTOR.PROC 1
dbpf $$CH1:PUMPSIZE.PROC 1
dbpf $$CH1:PNAME.PROC 1
dbpf $$CH1:ISENABLED.PROC 1

dbpf $$CH1:RELAY_FUNCTION_RB_1.PROC 1
dbpf $$CH1:TTL_FUNCTION_RB_1.PROC 1
dbpf $$CH1:AOMODE_1.PROC 1
dbpf $$CH1:DIMODE_1.PROC 1
epicsThreadSleep(3)
$$ENDIF(CH1)

$$IF(CH2)
dbpf $$CH2:PUMPSIZE.PROC 1
dbpf $$CH2:PNAME.PROC 1
dbpf $$CH2:CALFACTOR.PROC 1
dbpf $$CH2:PUMPSIZE.PROC 1
dbpf $$CH2:PNAME.PROC 1
dbpf $$CH2:ISENABLED.PROC 1

dbpf $$CH2:RELAY_FUNCTION_RB_2.PROC 1
dbpf $$CH2:TTL_FUNCTION_RB_2.PROC 1
dbpf $$CH2:AOMODE_2.PROC 1
dbpf $$CH2:DIMODE_2.PROC 1
epicsThreadSleep(3)
$$ENDIF(CH2)

$$IF(CH3)
dbpf $$CH3:PUMPSIZE.PROC 1
dbpf $$CH3:PNAME.PROC 1
dbpf $$CH3:CALFACTOR.PROC 1
dbpf $$CH3:PUMPSIZE.PROC 1
dbpf $$CH3:PNAME.PROC 1
dbpf $$CH3:ISENABLED.PROC 1

dbpf $$CH3:RELAY_FUNCTION_RB_3.PROC 1
dbpf $$CH3:TTL_FUNCTION_RB_3.PROC 1
dbpf $$CH3:AOMODE_3.PROC 1
dbpf $$CH3:DIMODE_3.PROC 1
epicsThreadSleep(3)
$$ENDIF(CH3)

$$IF(CH4)
dbpf $$CH4:PUMPSIZE.PROC 1
dbpf $$CH4:PNAME.PROC 1
dbpf $$CH4:CALFACTOR.PROC 1
dbpf $$CH4:PUMPSIZE.PROC 1
dbpf $$CH4:PNAME.PROC 1
dbpf $$CH4:ISENABLED.PROC 1

dbpf $$CH4:RELAY_FUNCTION_RB_4.PROC 1
dbpf $$CH4:TTL_FUNCTION_RB_4.PROC 1
dbpf $$CH4:AOMODE_4.PROC 1
dbpf $$CH4:DIMODE_4.PROC 1
epicsThreadSleep(3)
$$ENDIF(CH4)
$$ENDLOOP(QPC)