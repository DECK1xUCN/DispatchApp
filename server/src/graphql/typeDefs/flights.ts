import gql from "graphql-tag";

const flightsTypeDefs = gql`
  type Flight {
    id: Int!
    sites: [Site!]
  }

  type Site {
    id: Int!
    flights: [Flight!]
  }

  input CreateFlightInput {
    sites: [Int!]!
  }
  type Mutation {
    createFlight(input: CreateFlightInput!): Flight!
  }
  type Query {
    flights: [Flight!]!
    sites: [Site!]!
  }
`;
export default flightsTypeDefs;
