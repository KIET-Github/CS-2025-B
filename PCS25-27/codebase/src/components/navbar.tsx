import React from "react";
import { Button } from "./ui/button";
import { UserResponse } from "@supabase/supabase-js";
import { UserItem } from "./user-profile-items";
import Link from "next/link";

const Navbar = ({ session }: { session: UserResponse }) => {
  return (
    <div className="px-6 py-4 h-16 flex border-b shadow-md justify-between items-center">
      <Link className="text-3xl font-bold" href={"/"}>
        Safar
      </Link>
      <div>
        <>
          {session.error && (
            <Link href="/login">
              <Button>Sign in</Button>
            </Link>
          )}
        </>
        <>{session.data.user && <UserItem session={session} />}</>
      </div>
    </div>
  );
};

export default Navbar;
