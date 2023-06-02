import { AbiTypeToPrimitiveType } from "@latticexyz/schema-type";
import { StoreConfig } from "./storeConfig";

export type Templates<T extends StoreConfig> = {
  [k: string]: {
    [Table in keyof T["tables"]]?: {
      [Field in keyof T["tables"][Table]["schema"]]: AbiTypeToPrimitiveType<T["tables"][Table]["schema"][Field]>;
    };
  };
};

export type TemplateConfig = StoreConfig & { templates: Templates<StoreConfig> };
