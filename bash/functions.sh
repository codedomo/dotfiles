
scr(){
  if [ -z "$TMUX" ]; then
    echo "Please start tmux first!"
    exit 1
  fi

  local scratch_base_dir="$HOME/scratch"
  local current_date=$(date +%Y-%m-%d--%H:%M)
  local new_scratch_dir="${scratch_base_dir}/${current_date}"

  if [ -n "$1" ]; then
    local scratch_title=$( echo "$1" | sed 's/[^a-zA-Z0-9_-]/_/g')
    local new_scratch_dir+="--${scratch_title}"

    local window_title="scratch: ${scratch_title}"
  else
    local window_title="scratch"
  fi

  mkdir -p $new_scratch_dir
  echo ln -sf $new_scratch_dir/ $scratch_base_dir/current
  # ln -sf $new_scratch_dir/ $scratch_base_dir/current

  tmux new-window -n "$window_title" "cd ${new_scratch_dir}; bash -i"
}
