# Typescript + GraphQL API + Prisma + Postgresql

NodeJS server application that runs a GraphQL API using Prisma ORM & PostgreSQL".

## Installation

To install the application and its dependencies, run one of the following commands:

```
yarn install
```
```
npm ci
```
```
pnpm install
```

## Generating Prisma Client

Before starting the application, you need to generate the Prisma client by running one of the following commands:
```
pnpm prisma db push --schema src/prisma/schema.prisma
```
```
yarn prisma db push --schema src/prisma/schema.prisma
```
This will sync your Prisma client in the node_modules/.prisma/client directory with the database.


## Running the Application

To run the application, use one of the following commands:
```
yarn dev
```
```
pnpm dev
```

This will start the application and make the GraphQL API available at http://localhost:4000/graphql.
Application come with hot-reloading enabled, provided by nodemon, so any changes you make to the code will automatically be reflected in the running application.


## Running the Prisma Studio

To run the prisma studio (DB management studio), use one of the following commands:
```
pnpm prisma studio --schema src/prisma/schema.prisma
```
```
yarn prisma studio --schema src/prisma/schema.prisma
```
This will usualy start on localhost:5555
