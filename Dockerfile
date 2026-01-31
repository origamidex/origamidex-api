# ESTÁGIO 1: Compilação (Build)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copia apenas o arquivo de projeto para restaurar as dependências
COPY ["Origamix.Api/Origamix.Api.csproj", "Origamix.Api/"]
RUN dotnet restore "Origamix.Api/Origamix.Api.csproj"

# Copia o restante dos arquivos e compila
COPY . .
WORKDIR "/src/Origamix.Api"
RUN dotnet build "Origamix.Api.csproj" -c Release -o /app/build

# Publica a aplicação
FROM build AS publish
RUN dotnet publish "Origamix.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ESTÁGIO 2: Execução (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Variáveis para o Render
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 8080

ENTRYPOINT ["dotnet", "Origamix.Api.dll"]
