# Base image is asp.net core as a build environment
FROM microsoft/aspnetcore-build:2.0 AS build-env

LABEL maintainer="jonathan.madelaine@aeriandi.com"

# Copy Proj file into app directory of container
COPY ./src/*/*.csproj /app

# Restore dotnet packages
RUN dotnet restore

# Copy supporting files into app directory of container
COPY ./src/*/* /app

# Publish as a Release build into the /app/out 
RUN dotnet publish -c Release -o /app/out

# Expose port 8080
EXPOSE 8080

# Get clean layer of asp.net core as release env
FROM microsoft/aspnetcore:2.0

# Copy published 'release' files into /app directory of release env
COPY --from=build-env /app/out /app

ENTRYPOINT ["dotnet", "Jam.Service.NetCore.HelloWorld.dll"]