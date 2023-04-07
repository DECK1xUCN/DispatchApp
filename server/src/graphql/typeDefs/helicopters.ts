import gql from "graphql-tag";

const helicoptersTypeDefs = gql`
  type Query {
    helicopters: [Helicopter!]!
    helicopter(id: Int!): Helicopter!
  }
  type Mutation {
    createHelicopter(data: CreateHelicopterInput): Helicopter!
    updateHelicopter(id: String!, data: UpdateHelicopterInput!): Helicopter!
  }
  type Helicopter {
    id: Int!
    reg: String!
    model: String!
  }
  # Input types
  input CreateHelicopterInput {
    reg: String!
    model: String!
  }
  input UpdateHelicopterInput {
    reg: String
    model: String
  }
`;

export default helicoptersTypeDefs;
