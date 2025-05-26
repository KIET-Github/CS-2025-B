"use server";
import { createClient } from "@/utils/supabase/server";
import { registerFormSchema } from "@/lib/schema";
import { z } from "zod";

export async function signup(formData: z.infer<typeof registerFormSchema>) {
  const supabase = createClient();

  // type-casting here for convenience
  // in practice, you should validate your inputs
  const { email, password, username } = formData;

  const res = await supabase.auth.signUp({
    email: email,
    password: password,
    options: {
      data: {
        full_name: username,
      },
    },
  });
  return JSON.stringify(res);
}
