# Start with larger asp.net core-build image as this image is needed to build projects.
# Will be replaced with lightweight asp.net core runtime image in a later step.
FROM microsoft/aspnetcore-build:2.0 AS build-image
WORKDIR /app

LABEL maintainer="jonathan.madelaine@aeriandi.com"

# Copy Proj file into app directory of build image
COPY ./src/*/*.csproj ./

# Restore dotnet packages
RUN dotnet restore

# Copy supporting files into app directory of build image
COPY ./src/*/* ./

# Publish as a Release build into the /app/out directory of build image
RUN dotnet publish -c Release -o out

# Base image is replaced with asp.net core (runtime image) as it is smaller than the build image
FROM microsoft/aspnetcore:2.0
WORKDIR /app

# Copy published 'release' files from build image to runtime image
COPY --from=build-image /app/out ./

# Expose port 8080
EXPOSE 8080

# Define entrypoint for app in the form [<exec command>, <executable>]
ENTRYPOINT ["dotnet", "Jam.Service.NetCore.HelloWorld.dll"]