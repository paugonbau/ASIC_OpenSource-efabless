ARG BASE_IMAGE
FROM ${BASE_IMAGE} as base


## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:80/?password=start

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=80
EXPOSE $VNC_PORT $NO_VNC_PORT

### Envrionment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    NO_VNC_HOME=/dockerstartup/noVNC \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1680x1050 \
    VNC_PW=abc123 \
    VNC_VIEW_ONLY=false \
    DESIGNS=/foss/designs \
    TOOLS=/foss/tools \
    PDK_ROOT=/foss/pdks

ADD ./scripts/ $STARTUPDIR/scripts
RUN find $STARTUPDIR/scripts -name '*.sh' -exec chmod a+x {} +
RUN $STARTUPDIR/scripts/tools.sh

### Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN $STARTUPDIR/scripts/tigervnc.sh
RUN $STARTUPDIR/scripts/no_vnc.sh

### Install firefox
RUN $STARTUPDIR/scripts/firefox.sh

### Install xfce UI
RUN $STARTUPDIR/scripts/xfce_ui.sh
ADD ./addons/xfce/ $HOME/

FROM openlane:latest as openlane
FROM klayout:latest as klayout
FROM gtkwave:latest as gtkwave
FROM iverilog:latest as iverilog
FROM pdks-volare:latest as pdks
FROM magic:latest as magic
FROM netgen:latest as netgen
FROM riscv-gnu-toolchain-rv32i as rv32i
FROM gaw3-xschem as gaw3-xschem
FROM ngscope as ngscope
FROM ngspice as ngspice
FROM xyce as xyce
FROM covered as covered
FROM cvc as cvc
FROM opensta as opensta
FROM irsim as irsim
FROM base
#FROM dv as dv


COPY --from=pdks        	/foss/pdks/    		/foss/pdks/
COPY --from=openlane   	 	/foss/tools/openlane      		/foss/tools/openlane
COPY --from=openlane   		/foss/tools/openlane_tools      	/foss/tools/openlane_tools
COPY --from=gtkwave    		/foss/tools/   		/foss/tools/
COPY --from=iverilog   		/foss/tools/   		/foss/tools/
COPY --from=magic      		/foss/tools/   		/foss/tools/
COPY --from=netgen     		/foss/tools/   		/foss/tools/
COPY --from=klayout    		/foss/tools/   		/foss/tools/
COPY --from=rv32i 	    	/foss/tools/   		/foss/tools/
COPY --from=gaw3-xschem        	/foss/tools/   		/foss/tools/
COPY --from=ngscope    		/foss/tools/   		/foss/tools/
COPY --from=ngspice	       	/foss/tools/   		/foss/tools/
COPY --from=xschem	       	/foss/tools/   		/foss/tools/
COPY --from=xyce	       	/foss/tools/   		/foss/tools/
COPY --from=covered	       	/foss/tools/   		/foss/tools/
COPY --from=opensta    		/foss/tools/   		/foss/tools/
COPY --from=cvc     	  	/foss/tools/   		/foss/tools/
COPY --from=irsim    		/foss/tools/   		/foss/tools/
#COPY --from=dv   		/foss/tools/   		/foss/tools/


ADD  ./addons/sak 		/foss/tools/sak
COPY ./addons/.klayout/ 	/headless/.klayout/
COPY ./addons/.gaw/ 	    	/headless/.gaw/
COPY ./addons/examples 		/foss/examples
COPY ./addons/.spiceinit 	/headless/.spiceinit
COPY ./addons/spice.rc 		/headless/spice.rc


ADD ./scripts/env.sh $HOME/.bashrc
RUN bash $HOME/.bashrc

ADD ./scripts/miscellaneous.sh  $STARTUPDIR/scripts/miscellaneous.sh
RUN bash $STARTUPDIR/scripts/miscellaneous.sh

### configure startup
RUN $STARTUPDIR/scripts/libnss_wrapper.sh
RUN $STARTUPDIR/scripts/set_user_permission.sh $STARTUPDIR $HOME

WORKDIR $DESIGNS

USER 1000

ENTRYPOINT ["/dockerstartup/scripts/vnc_startup.sh"]

CMD ["--wait"]

