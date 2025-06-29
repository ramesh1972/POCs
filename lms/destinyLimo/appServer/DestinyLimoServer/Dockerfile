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

# Create the uploads directory with subfolder if it doesn't exist
RUN mkdir -p /home/chordify-services/lms-poc/prod/appServer/DestinyLimoServer/uploads/destiny-uploads

# Set the correct permissions and ownership (replace 'appuser' with your actual runtime user)
RUN chown -R ubuntu:ubuntu /home/chordify-services/lms-poc/prod/appServer/DestinyLimoServer/uploads/destiny-uploads && \
    chmod -R 755 /home/chordify-services/lms-poc/prod/appServer/DestinyLimoServer/uploads/destiny-uploads

# Declare the uploads folder as a volume
VOLUME ["/home/chordify-services/lms-poc/prod/appServer/DestinyLimoServer/uploads/destiny-uploads"]

# Start the application
ENTRYPOINT ["dotnet", "DestinyLimoServer.dll"]
