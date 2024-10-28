# Use the official ASP.NET Core runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5293
ENV ASPNETCORE_URLS=http://+:5293
ENV ASPNETCORE_ENVIRONMENT=Production

# Use the SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["DestinyLimoServer.csproj", "./"]
RUN dotnet restore "./DestinyLimoServer.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "DestinyLimoServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DestinyLimoServer.csproj" -c Release -o /app/publish

# Final stage: create the runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DestinyLimoServer.dll"]
