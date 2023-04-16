import gql from "graphql-tag";

const helicopterTypeDefs = gql`
  type Helicopter {
    id: Int!
    name: String!
    model: String!
    reg: String!
    flights: [Flight!]!
  }
  input CreateHelicopterInput {
    name: String!
    model: String!
    reg: String!
  }
  type Query {
    helicopter(id: Int!): Helicopter!
    helicoptersWhereModel(model: String!): [Helicopter!]!
    helicopters: [Helicopter!]!
  }
  type Mutation {
    createHelicopter(data: CreateHelicopterInput!): Helicopter!
  }
`;
export default helicopterTypeDefs;
