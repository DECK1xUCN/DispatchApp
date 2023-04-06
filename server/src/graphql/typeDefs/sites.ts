import gql from "graphql-tag";

const sitesTypeDefs = gql`
  type Query {
    sites: [Site!]!
    site(id: Int!): Site!
  }
  type Mutation {
    createSite(data: SiteInput): Site!
    updateSite(id: Int!, data: SiteInput!): Site!
  }
  type Site {
    id: Int!
    name: String!
  }
  # Input types
  input SiteInput {
    name: String!
  }
`;
export default sitesTypeDefs;
