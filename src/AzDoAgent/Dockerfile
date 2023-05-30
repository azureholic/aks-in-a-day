FROM mcr.microsoft.com/windows/servercore:ltsc2022 as base
WORKDIR /azp
COPY install.ps1 .
COPY download.ps1 .

ARG AZP_URL
ARG AZP_TOKEN
ARG AZP_POOL

ENV AZP_URL=$AZP_URL
ENV AZP_TOKEN=$AZP_TOKEN
ENV AZP_POOL=$AZP_POOL

RUN powershell .\download.ps1

FROM base AS final
WORKDIR /azp
CMD ["powershell", ".\\install.ps1"]