TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install)
# databases, templates, substitutions like this
DB_INSTALLS += $(IOCADMIN)/db/iocSoft.db
DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db
DB_INSTALLS += $(ASYN)/db/asynRecord.db
DB_INSTALLS += $(QPC)/db/qpc_channel_common.db
DB_INSTALLS += $(QPC)/db/qpc_channel_v1.db
DB_INSTALLS += $(QPC)/db/qpc_channel_v2.db
DB_INSTALLS += $(QPC)/db/qpc_controller_common.db
DB_INSTALLS += $(QPC)/db/qpc_controller_v2.db

DB += vac_mks937a_serial.template
DB += vac_mks937a_serial_cc.template
DB += vac_mks937a_serial_mp.template
DB += vac_mks937a_serial_pr.template
DB += vac_mks937a_serial_tc.template

DB += vac_mks937b_serial.template
DB += vac_mks937b_serial_cc.template
DB += vac_mks937b_serial_pr.template

DB += twistorr.db twistorr_ro.db

DB += navigator.db


#----------------------------------------------------
# Create and install (or just install)
# Archive files, templates, substitutions like this
#
# ARCHIVE += vacuum-ioc.archive

ARCHIVE += archive_937a_pr.tpl-arch archive_937a_cc.tpl-arch
ARCHIVE += archive_937b_pr.tpl-arch archive_937b_cc.tpl-arch
ARCHIVE += archive_937a_tc.tpl-arch archive_937a_mp.tpl-arch
ARCHIVE += archive_937b_tc.tpl-arch archive_937b_mp.tpl-arch

ARCHIVE_INSTALLS += $(QPC)/archive/qpc_controller.tpl-arch
ARCHIVE_INSTALLS += $(QPC)/archive/qpc_channel.tpl-arch

ARCHIVE += srg.archive

ARCHIVE += archive_twistorr.tpl-arch


#----------------------------------------------------
# Create and install (or just install)
# Autosave request files, templates, substitutions like this
#
# REQ += vacuum-ioc.req

REQ += autosave_937a_pr.tpl-req autosave_937a_cc.tpl-req
REQ += autosave_937b_pr.tpl-req autosave_937b_cc.tpl-req
REQ += autosave_937a_tc.tpl-req autosave_937a_mp.tpl-req
REQ += autosave_937b_tc.tpl-req autosave_937b_mp.tpl-req

REQ_INSTALLS += $(QPC)/autosave/qpc_controller.tpl-req
REQ_INSTALLS += $(QPC)/autosave/qpc_channel.tpl-req


include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
