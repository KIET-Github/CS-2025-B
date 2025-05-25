"use client";
import { useEffect, useContext, useState } from "react";

import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { useSearchParams } from "next/navigation";

import { Button } from "@/components/ui/button";
import { createClient } from "@/utils/supabase/client";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

import { Session, UserResponse } from "@supabase/supabase-js";
import { ChevronsLeftRight } from "lucide-react";
import { useToast } from "./ui/use-toast";

export function UserItem({ session }: { session: UserResponse }) {
  const router = useRouter();
  const { toast } = useToast();

  const supabase = createClient();
  const handleLogOut = async () => {
    await supabase.auth.signOut();
    router.push("/");
    router.refresh();
    toast({
      variant: "default",
      title: "Log out Successful.",
      description: "Looking forward to see you soon",
    });
  };
  return (
    <div className="flex p-4 z-[99999]">
      <>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <div className="flex text-sm justify-between items-center  space-x-2 cursor-pointer">
              <Avatar className="h-8 w-8">
                <AvatarImage
                  src={session.data.user?.user_metadata.avatar_url ?? ""}
                  alt={session.data.user?.user_metadata.full_name ?? ""}
                />
                <AvatarFallback>
                  {session.data.user?.user_metadata.full_name?.[0]}
                </AvatarFallback>
              </Avatar>
            </div>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="w-56" align="end" forceMount>
            <DropdownMenuLabel className="font-normal">
              <div className="flex flex-col space-y-1">
                <p className="text-sm font-medium leading-none">
                  {session.data.user?.user_metadata.full_name}
                </p>
                <p className="text-xs leading-none text-muted-foreground">
                  {session.data.user?.user_metadata.email}
                </p>
              </div>
            </DropdownMenuLabel>
            <DropdownMenuItem asChild>
              <Link href="/profile">Profile</Link>
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem className="cursor-pointer" onClick={handleLogOut}>
              Log out
              <DropdownMenuShortcut>⇧⌘Q</DropdownMenuShortcut>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </>
    </div>
  );
}
