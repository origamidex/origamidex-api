# Estágio de Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1. Copia o arquivo de projeto usando o caminho da subpasta
COPY ["Origamix.Api/Origamix.Api.csproj", "Origamix.Api/"]

# 2. Restaura as dependências
RUN dotnet restore "Origamix.Api/Origamix.Api.csproj"

# 3. Copia todo o conteúdo da pasta Origamix.Api
COPY ["Origamix.Api/", "Origamix.Api/"]

# 4. Compila e publica
WORKDIR "/src/Origamix.Api"
RUN dotnet publish "Origamix.Api.csproj" -c Release -o /app/publish

# Estágio Final (Runtime)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Porta padrão do Render
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "Origamix.Api.dll"]
