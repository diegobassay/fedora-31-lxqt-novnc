FROM fedora
LABEL maintainer="diegobassay@gmail.com"

RUN yum -y update && yum clean all
RUN yum -y install git supervisor passwd @lxqt && yum clean all

ENV USER budi
ENV HOME /home/$USER
RUN adduser $USER
RUN echo 'budi' | passwd budi --stdin
RUN usermod -aG wheel budi
RUN chown -R $USER:$USER $HOME

WORKDIR $HOME

ADD https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.10.1.x86_64.tar.gz $HOME/tigervnc/tigervnc.tar.gz
RUN tar xmzf $HOME/tigervnc/tigervnc.tar.gz -C $HOME/tigervnc/ && rm $HOME/tigervnc/tigervnc.tar.gz
RUN cp -R $HOME/tigervnc/tigervnc-1.10.1.x86_64/* / && rm -rf $HOME/tigervnc/

RUN git clone https://github.com/novnc/noVNC.git $HOME/novnc
RUN cp $HOME/novnc/vnc.html $HOME/novnc/index.html

RUN git clone https://github.com/kanaka/websockify $HOME/novnc/utils/websockify

RUN rm -rf /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

COPY supervisord.conf /etc

RUN touch $HOME/startup.sh && chmod +x $HOME/startup.sh && printf "#!/bin/bash\n\
[ -f $HOME/.vnc/passwd ] && vncserver -kill :1 && rm -rf $HOME/.vnc && rm -rf /tmp/.X1*\n\
su $USER -c \"mkdir $HOME/.vnc && echo 'budi' | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources\"\n\
echo 'run supervisor'\n\
/usr/bin/supervisord -n\n\
" >> $HOME/startup.sh

CMD ["/bin/bash", "-c", "$HOME/startup.sh"]