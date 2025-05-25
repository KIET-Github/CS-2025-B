import { z } from "zod";

export const loginFormSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8, "Password should be 8 characters long"),
});

export const registerFormSchema = z
  .object({
    username: z.string().min(1, "Please enter your username"),
    email: z.string().email(),
    password: z.string().min(8, "Password should be 8 characters long"),
    confirmPassword: z.string(),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "Passwords don't match",
    path: ["confirmPassword"],
  });

export const bookingSchema = z.object({
  date: z.date({ required_error: "Date of visit is required" }),
  childrens: z.string(),
  adults: z.string(),
});
