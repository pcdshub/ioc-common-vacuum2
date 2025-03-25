# ioc-common-generic_streamdevice
This is an EPICS IOC that is used at LCLS. This repo was automatically transferred to github from an internal filesystem repository via the scripts at https://github.com/pcdshub/afs_ioc_migration.

The original filesystem location was /afs/slac.stanford.edu/g/cd/swe/git/repos/package/epics/ioc/common/generic_streamdevice.git.


## Original readme files
### README
This is a generic streamdevice IOC.  It doesn't do anything, but is
intended to be a skeleton to be copied to make a useful IOC that 
communicates with a device using a text-based protocol over TCP/IP.

What needs to be added to make this a useful IOC?
    - app/srcProtocol/gsd.proto needs to have a protocol added to it.
    - app/Db/gsd.db needs to have records added that use this protocol.
    - app/Db/gsd.req needs to have a list of PVs for autosaving.
    - app/Db/gsd.archive needs to have a list of PVs and periods for
      archiving.
    - gsdScreens needs to have a top level screen defined.
    - iocBoot/templates/edm-ioc.sh needs to be changed to call edm
      on this top-level screen.

In general, "gsd" is not the greatest name for things in the IOC.  You
might want to copy these files, and then go through and change these to
names more appropriate to the actual IOC being developed.

