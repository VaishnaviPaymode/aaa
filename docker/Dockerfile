# # Set build configuration
ARG BUILD_CONFIGURATION=Release

# Use SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Fix this line: point to the actual subfolder
 COPY ["./ELabel.csproj", "./"]
RUN dotnet restore "./ELabel.csproj"

# Copy rest of the source
COPY . .

RUN dotnet publish "./ELabel.csproj" -c $BUILD_CONFIGURATION -o /app/publish

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "ELabel.dll"]
