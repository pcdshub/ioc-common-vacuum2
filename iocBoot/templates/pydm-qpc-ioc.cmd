#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup pydm environment
source /cds/group/pcds/pyps/conda/pcds_conda

export TOP_SCREEN=$$IOCTOP/screens/qpc_main.ui
$$LOOP(QPC)
pydm -m " BASE=$$BASE,$$IF(CH1)CH1=$$CH1,$$ENDIF(CH1)$$IF(CH2)CH2=$$CH2,$$ENDIF(CH2)$$IF(CH3)CH3=$$CH3,$$ENDIF(CH3)$$IF(CH4)CH4=$$CH4,$$ENDIF(CH4)" $TOP_SCREEN & 
$$ENDLOOP(QPC)
