FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . . 
RUN ls -al  # Kiểm tra file trong /src
RUN dotnet restore "Hotel.API/Hotel.API.csproj"  # Chỉ định đúng đường dẫn
RUN dotnet publish "Hotel.API/Hotel.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish . 
ENTRYPOINT ["dotnet", "Hotel.API.dll"]
