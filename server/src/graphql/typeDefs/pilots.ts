import gql from "graphql-tag";

const pilotsTypeDefs = gql`
  type Pilot {
    id: Int!
    name: String!
    flights: [Flight!]!
  }
  type Query {
    pilot(id: Int!): Pilot!
    pilots: [Pilot!]!
  }
  type Mutation {
    createPilot(name: String!): Pilot!
    updatePilot(id: Int!, name: String!): Pilot!
  }
`;

export default pilotsTypeDefs;
