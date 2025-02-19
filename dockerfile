FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/donet/sdk:5.0 as publish
WORKDIR /src
COPY . . 
RUN dotnet restore WebApplication.csproj
RUN dotnet build WebApplication.csproj -c Release -o /publish/
RUN dotnet publish WebApplication.csproj -c Release -o /publish/

FROM base AS final
WORKDIR /app
COPY --from=publish /src/bin/Release/net5.0/ .
COPY /wwwroot ./wwwroot
ENTRYPOINT ["dotnet","WebApplication1.dll"]