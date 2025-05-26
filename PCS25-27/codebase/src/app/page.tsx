import React from "react";
import { createClient } from "@/utils/supabase/server";
import PopularCities from "@/components/popular-cities";
import ExploreCities from "@/components/explore-cities";
const page = async () => {
  const supabase = createClient();

  const { data, error } = await supabase.auth.getUser();
  return (
    <div className="pb-8">
      <PopularCities />
      <ExploreCities />
    </div>
  );
};

export default page;
