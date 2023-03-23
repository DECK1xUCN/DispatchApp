import gql from "graphql-tag";

const flightTypeDefs = gql`
  scalar DateTime
  scalar Date

  type Flight {
    from: String!
    via: String!
    to: String!
    flightNumber: String!
    ETD: Date!
    PAX: Int!
    cargo: Int!
    hoistCycles: Int!
    lateNote: String
    delayCode: String
  }

  type Query {
    flight: [Flight!]!
  }
  type Mutation {
    createFlight(
      from: String!
      via: String!
      to: String!
      flightNumber: String!
      ETD: Date!
      PAX: Int!
      cargo: Int!
      hoistCycles: Int!
      lateNote: String
      delayCode: String
    ): Boolean!
  }
`;

export default flightTypeDefs;
