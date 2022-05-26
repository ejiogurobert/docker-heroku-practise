FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS base
WORKDIR /src/
COPY CatalogApi.cspraj ./
RUN  dotnet restore ./CatalogApi.cspraj
COPY ./ ./
RUN dotnet build -c Release -o ./app/build
RUN dotnet publish -c Release -o ./app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=base /src/app/publish ./
EXPOSE 80
EXPOSE 443
CMD ["dotnet", "CatalogApi.dil"]