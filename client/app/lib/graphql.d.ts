declare module "*.graphql" {
  import { DocumentNode } from "~/lib/graphql";
  const Schema: DocumentNode;

  export = Schema;
}
