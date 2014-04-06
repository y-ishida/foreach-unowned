using Gee;

class Vector : Object
{
	public int x;
	public int y;

	public Vector(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
}

void print_count_pre()
{
	print("  ref_counts = { ");
}

bool print_count(uint n)
{
	print("%u ", n);
	return true;
}

void print_count_post()
{
	print("}\n");
}

void show_ref_count_owned(AbstractCollection<Vector> t)
{
	print_count_pre();
	t.foreach((v) => { return print_count(v.ref_count); });
	print_count_post();
}

void show_ref_count_unowned(AbstractCollection<unowned Vector> t)
{
	print_count_pre();
	t.foreach((v) => { return print_count(v.ref_count); });
	print_count_post();
}

int main(string[] args)
{
	var owned_list = new ArrayList<Vector>();
	for(int i = 0; i < 5; i++)
		owned_list.add(new Vector(i, 5 - i));

	var unowned_list = new ArrayList<unowned Vector>();
	owned_list.foreach((v) => {
		unowned_list.add(v);
		return true;
	});

	print("OWNED LIST (1)\n");
	show_ref_count_owned(owned_list);

	print("OWNED LIST (2)\n");
	show_ref_count_owned(owned_list);

	print("UNOWNED LIST (1)\n");
	show_ref_count_owned(unowned_list); // wrong

	print("UNOWNED LIST2 (2)\n");
	show_ref_count_owned(unowned_list); // wrong

	/*
	// correct
	print("UNOWNED LIST (1)\n");
	show_ref_count_unowned(unowned_list);

	print("UNOWNED LIST2 (2)\n");
	show_ref_count_unowned(unowned_list);
	*/

	return 0;
}


