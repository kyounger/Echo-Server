FROM arm64v8/node:10-alpine3.10 as build
WORKDIR /build
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM arm64v8/node:10-alpine3.10
WORKDIR /app
COPY ./src/global.json .
COPY --from=build /build/dist/webserver.js .

ENTRYPOINT [ "node", "webserver" ]
