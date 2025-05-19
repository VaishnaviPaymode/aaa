FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["ELabel/ELabel.csproj", "ELabel/"]

RUN dotnet restore "ELabel/ELabel.csproj"


# Copy everything else and build
COPY . .
RUN dotnet build --no-restore -c Release

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM build AS publish
RUN dotnet publish --no-build -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ELabel.dll"]
# Replace this line:
COPY ["./ELabel.csproj", "./"]
# With the correct project file name, for example:
COPY ["*.csproj", "./"]