import gql from "graphql-tag";

const pilotsTypeDefs = gql`
  type Pilot {
    id: Int!
    name: String!
    flights: [Flight!]!
  }
  input CreatePilot {
    name: String!
  }
  type Query {
    pilot(id: Int!): Pilot!
    pilots: [Pilot!]!
  }
  type Mutation {
    createPilot(data: CreatePilot!): Pilot!
  }
`;

export default pilotsTypeDefs;
