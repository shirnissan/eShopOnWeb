FROM ${DOCKER_REGISTRY-}eshoppublicapi
WORKDIR /app
COPY . .
EXPOSE 8080
ENTRYPOINT ["dotnet", "eShopOnWeb.dll"]
