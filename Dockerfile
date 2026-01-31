# ESTÁGIO 1: Compilação (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia apenas o arquivo de projeto para restaurar as dependências
# O projeto se chama 'origamidex-api.csproj' dentro da pasta 'origamidex-api'
COPY ["origamidex-api/origamidex-api.csproj", "origamidex-api/"]
RUN dotnet restore "origamidex-api/origamidex-api.csproj"

# Copia o restante dos arquivos e compila
COPY . .
WORKDIR "/src/origamidex-api"
RUN dotnet build "origamidex-api.csproj" -c Release -o /app/build

# Publica a aplicação
FROM build AS publish
RUN dotnet publish "origamidex-api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ESTÁGIO 2: Execução (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Variáveis para o Render
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 8080

ENTRYPOINT ["dotnet", "origamidex-api.dll"]
