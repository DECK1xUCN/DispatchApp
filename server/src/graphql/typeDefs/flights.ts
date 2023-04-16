import gql from "graphql-tag";

const flightsTypeDefs = gql`
  type Flight {
    id: Int!
    sites: [Site!]
    helicopter: Helicopter!
    pilot: Pilot!
    hoistOperator: HoistOperator!
  }

  input CreateFlightInput {
    sites: [Int!]!
    helicopterId: Int!
    pilotId: Int!
    hoistOperatorId: Int!
  }
  type Mutation {
    createFlight(input: CreateFlightInput!): Flight!
  }
  type Query {
    flights: [Flight!]!
  }
`;
export default flightsTypeDefs;
