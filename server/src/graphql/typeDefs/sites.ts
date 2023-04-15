import gql from "graphql-tag";

const siteTypeDefs = gql`
  type Site {
    id: Int!
    name: String!
    locations: [Location!]!
  }
  type Query {
    site(id: Int!): Site!
    sites: [Site!]!
  }
  type Mutation {
    createSite(name: String!): Site!
    # updateSite(id: Int!, name: String!): Site!
  }
`;
export default siteTypeDefs;
