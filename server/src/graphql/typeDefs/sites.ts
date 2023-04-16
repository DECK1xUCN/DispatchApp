import gql from "graphql-tag";

const siteTypeDefs = gql`
  type Site {
    id: Int!
    name: String!
    locations: [Location!]!
    flights: [Flight!]!
  }
  type Query {
    site(id: Int!): Site!
    sites: [Site!]!
  }
  input CreateSiteInput {
    name: String!
  }
  type Mutation {
    createSite(data: CreateSiteInput!): Site!
    # updateSite(id: Int!, name: String!): Site!
  }
`;
export default siteTypeDefs;
