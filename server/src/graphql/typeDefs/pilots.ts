import gql from "graphql-tag";

const pilotsTypeDefs = gql`
  type Query {
    pilots: [Pilot!]!
    pilot(id: Int!): Pilot!
  }
  type Mutation {
    createPilot(data: PilotInput): Pilot!
    updatePilot(id: Int!, data: PilotInput!): Pilot!
  }
  type Pilot {
    id: Int!
    name: String!
  }
  # Input types
  input PilotInput {
    name: String!
  }
`;
export default pilotsTypeDefs;
