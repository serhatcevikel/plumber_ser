#FROM trestletech/plumber
FROM debian:latest
#FROM gesiscss/binder-serhatcevikel-2dplumber-5fser-71bb3b:c17c3fe77bbe14862765b5dfb22f75058935e420
LABEL maintainer="serhatcevikel@yahoo.com"

RUN apt update && \
    apt upgrade -y && \
    apt dist-upgrade -y && \
    apt autoremove -y && \
    apt install -y \
    r-base \
    libcurl4-openssl-dev \
    libicu-dev \
    libsodium-dev \
    libssl-dev \
    make;

RUN R -e "install.packages(c('plumber', 'httr', 'jsonlite', 'e1071', 'rpart'), \
repos = 'http://cran.us.r-project.org')"

COPY ./plumber5.R /plumber5.R

EXPOSE 8000

ENTRYPOINT ["R", "-e", \
"predict <- plumber::plumb('plumber5.R'); \
predict$run(host = '0.0.0.0', port= 8000)"]

#CMD ["/plumber5.R"]
CMD ["/bin/bash"]
