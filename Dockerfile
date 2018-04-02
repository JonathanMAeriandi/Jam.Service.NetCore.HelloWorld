FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY ./src/*/*.csproj ./
RUN dotnet restore

# copy everything else and build
COPY ./src/*/* ./
RUN dotnet publish -c Release -o out

EXPOSE 8080

# build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Jam.Service.NetCore.HelloWorld.dll"]