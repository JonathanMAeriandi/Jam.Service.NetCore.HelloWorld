FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

LABEL maintainer="jonathan.madelaine@aeriandi.com"

# Copy Proj file into container
COPY ./src/*/*.csproj ./
RUN dotnet restore

# Copy supporting files into container
COPY ./src/*/* ./
RUN dotnet publish -c Release -o out

EXPOSE 8080

FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "*.NetCore.*.dll"]