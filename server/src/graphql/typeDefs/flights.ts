import gql from "graphql-tag";

const flightsTypeDefs = gql`
  type Flight {
    id: Int!
    sites: [Site!]
    helicopter: Helicopter!
  }

  input CreateFlightInput {
    sites: [Int!]!
  }
  type Mutation {
    createFlight(input: CreateFlightInput!): Flight!
  }
  type Query {
    flights: [Flight!]!
  }
`;
export default flightsTypeDefs;
