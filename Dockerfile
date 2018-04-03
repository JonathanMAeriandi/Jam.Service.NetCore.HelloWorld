# Base image is asp.net core as a build environment
FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app
LABEL maintainer="jonathan.madelaine@aeriandi.com"

# Copy Proj file into app directory of container
COPY ./src/*/*.csproj ./

# Restore dotnet packages
RUN dotnet restore

# Copy supporting files into app directory of container
COPY ./src/*/* ./

# Publish as a Release build into the /app/out 
RUN dotnet publish -c Release -o out

# Expose port 8080
EXPOSE 8080

# Get clean layer of asp.net core as release env
FROM microsoft/aspnetcore:2.0
WORKDIR /app

# Copy published 'release' files into /app directory of release env
COPY --from=build-env /app/out ./

ENTRYPOINT ["dotnet", "Jam.Service.NetCore.HelloWorld.dll"]